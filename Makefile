.POSIX:
.SUFFIXES:

# SHELL        := env PATH=$(TAMARIN_DIR):$(PATH) /bin/sh
SHELL 		 := /bin/sh
TAMARIN       = tamarin-prover
TAMARIN_FLAGS = --quit-on-warning 

# Directories
LIB           = ./mtproto2.spthy
SRC_DIR       = ./src
LEMMAS_DIR    = lemmas
ENC           = model1
DEBUG_DIR     = debug
OUTPUT_DIR    = ./out
UTT_DIR       = ./utt_configs

# Sources
LIB_SRC       = $(SRC_DIR)/preamble.spthy
LIB_SRC      += $(SRC_DIR)/mtproto2-common.spthy
LIB_SRC      += $(SRC_DIR)/mtproto2-encryption/$(ENC)/mtproto2-encryption-common.spthy
LIB_SRC      += $(SRC_DIR)/mtproto2-encryption/$(ENC)/mtproto2-encryption-authorization.spthy
LIB_SRC      += $(SRC_DIR)/mtproto2-encryption/$(ENC)/mtproto2-encryption-part-i.spthy
LIB_SRC      += $(SRC_DIR)/mtproto2-authorization.spthy
LIB_SRC      += $(SRC_DIR)/mtproto2-cloud-chat.spthy


# Debug
DEBUG_SRC     = $(SRC_DIR)/$(DEBUG_DIR)/mtproto2-authorization.spthy
DEBUG_SRC    += $(SRC_DIR)/$(DEBUG_DIR)/mtproto2-cloud-chat.spthy
DEBUG_SRC    += $(SRC_DIR)/epilogue.spthy


# Security properties

# Authorization
AUTH          = authorization
LEMMAS_SRC    = $(SRC_DIR)/$(LEMMAS_DIR)/$(AUTH)/agreement.spthy
LEMMAS_SRC   += $(SRC_DIR)/$(LEMMAS_DIR)/$(AUTH)/authentication-client-to-server.spthy
LEMMAS_SRC   += $(SRC_DIR)/$(LEMMAS_DIR)/$(AUTH)/authentication-server-to-client.spthy
LEMMAS_SRC   += $(SRC_DIR)/$(LEMMAS_DIR)/$(AUTH)/broken-agreement.spthy
LEMMAS_SRC   += $(SRC_DIR)/$(LEMMAS_DIR)/$(AUTH)/key-secrecy.spthy
LEMMAS_SRC   += $(SRC_DIR)/$(LEMMAS_DIR)/$(AUTH)/session.spthy

# Cloud-chat
CLOUD_CHAT    = cloud-chat
LEMMAS_SRC   += $(SRC_DIR)/$(LEMMAS_DIR)/$(CLOUD_CHAT)/secrecy.spthy
LEMMAS_SRC   += $(SRC_DIR)/$(LEMMAS_DIR)/$(CLOUD_CHAT)/kci.spthy
LEMMAS_SRC   += $(SRC_DIR)/epilogue.spthy

# Observational equivalence lemmas
DIFF_SRC      = $(SRC_DIR)/$(LEMMAS_DIR)/$(AUTH)/key-strong-secrecy.spthy
DIFF_SRC     += $(SRC_DIR)/$(LEMMAS_DIR)/$(AUTH)/nk-strong-secrecy.spthy
DIFF_SRC     += $(SRC_DIR)/epilogue.spthy

# Run
UTT_EXEC     := uttamarin 
UTT_CONF      = $(UTT_DIR)/utt_config.json
UTT_CONF_DBG  = $(UTT_DIR)/utt_config_dbg.json 
UTT_OUT       = $(OUTPUT_DIR)/utt_output.txt
UTT_OUT_DBG   = $(OUTPUT_DIR)/utt_output_dbg.txt
UTT_FLAGS     = 


# Make rules
.PHONY: run
run: 	$(LIB) out
	cat $(LEMMAS_SRC) >> $(LIB)
	$(UTT_EXEC) $(UTT_FLAGS) -c $(UTT_CONF) -o $(UTT_OUT) $(LIB)


.PHONY: diff
diff:    $(LIB) out
	cat $(DIFF_SRC) >> $(LIB)
	$(TAMARIN) interactive $(LIB) $(TAMARIN_FLAGS) --diff
	

.PHONY: debug
debug: 	$(LIB) out
	cat $(DEBUG_SRC) >> $(LIB)
	$(UTT_EXEC) $(UTT_FLAGS) -c $(UTT_CONF_DBG) -o $(UTT_OUT_DBG) $(LIB)


.PHONY: $(LIB)
$(LIB):
	cat $(LIB_SRC) > $(LIB)


.PHONY: out
out:
	mkdir -p $(OUTPUT_DIR)


.PHONY: clean
clean:
	rm -f client_session_key.aes
	rm -f $(LIB)
	rm -f $(UTT_OUT)
	rm -f $(UTT_OUT_DBG)
	rm -rf $(OUTPUT_DIR)
