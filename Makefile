.POSIX:
.SUFFIXES:

# SHELL        := env PATH=$(TAMARIN_DIR):$(PATH) /bin/sh
SHELL 		   := /bin/sh
TAMARIN         = tamarin-prover
TAMARIN_FLAGS   = --quit-on-warning 

# Output source files
AUTH_FILE        = ./mtproto2-authorization.spthy
SECRET_CHAT_FILE = ./mtproto2-secretchat.spthy
REKEYING_FILE    = ./mtproto2-rekeying.spthy
CLOUD_CHAT_FILE  = ./mtproto2-cloudchat.spthy

# Directories
SRC_DIR         = ./src
LEMMAS_DIR      = lemmas
ENC             = model1
DEBUG_DIR       = debug
UTT_DIR         = ./utt_configs

########################################################
# Authorization protocol                               #
########################################################
AUTH         = authorization
AUTH_UTT     = $(UTT_DIR)/auth.json
AUTH_UTT_DBG = $(UTT_DIR)/auth_dbg.json

# Protocol definition
AUTH_LIB  = $(SRC_DIR)/preamble.spthy
AUTH_LIB += $(SRC_DIR)/mtproto2-common.spthy
AUTH_LIB += $(SRC_DIR)/mtproto2-encryption/$(ENC)/mtproto2-encryption-common.spthy
AUTH_LIB += $(SRC_DIR)/mtproto2-encryption/$(ENC)/mtproto2-encryption-authorization.spthy
AUTH_LIB += $(SRC_DIR)/mtproto2-encryption/$(ENC)/mtproto2-encryption-part-i.spthy
AUTH_LIB += $(SRC_DIR)/mtproto2-authorization.spthy

# Debug lemmas
AUTH_DEBUG  = $(SRC_DIR)/$(DEBUG_DIR)/mtproto2-authorization.spthy
AUTH_DEBUG += $(SRC_DIR)/epilogue.spthy

# Lemmas
AUTH_LEMMAS  = $(SRC_DIR)/$(LEMMAS_DIR)/$(AUTH)/agreement.spthy
AUTH_LEMMAS += $(SRC_DIR)/$(LEMMAS_DIR)/$(AUTH)/authentication.spthy
AUTH_LEMMAS += $(SRC_DIR)/$(LEMMAS_DIR)/$(AUTH)/key-secrecy.spthy
AUTH_LEMMAS += $(SRC_DIR)/$(LEMMAS_DIR)/$(AUTH)/session.spthy
AUTH_LEMMAS += $(SRC_DIR)/epilogue.spthy

# Observational equivalence lemmas
AUTH_DIFF_LEMMAS  = $(SRC_DIR)/$(LEMMAS_DIR)/$(AUTH)/key-strong-secrecy.spthy
AUTH_DIFF_LEMMAS += $(SRC_DIR)/$(LEMMAS_DIR)/$(AUTH)/nk-strong-secrecy.spthy
AUTH_DIFF_LEMMAS += $(SRC_DIR)/epilogue.spthy

########################################################
# Cloud chat protocol                                  #
########################################################
CLOUD_CHAT         = cloud-chat
CLOUD_CHAT_UTT     = $(UTT_DIR)/cloud_chat.json
CLOUD_CHAT_UTT_DBG = $(UTT_DIR)/cloud_chat_dbg.json

# Protocol definition
CLOUD_CHAT_LIB  = $(SRC_DIR)/preamble.spthy
CLOUD_CHAT_LIB += $(SRC_DIR)/mtproto2-common.spthy
CLOUD_CHAT_LIB += $(SRC_DIR)/mtproto2-encryption/$(ENC)/mtproto2-encryption-common.spthy
CLOUD_CHAT_LIB += $(SRC_DIR)/mtproto2-encryption/$(ENC)/mtproto2-encryption-authorization.spthy
CLOUD_CHAT_LIB += $(SRC_DIR)/mtproto2-encryption/$(ENC)/mtproto2-encryption-part-i.spthy
CLOUD_CHAT_LIB += $(SRC_DIR)/mtproto2-authorization.spthy
CLOUD_CHAT_LIB += $(SRC_DIR)/mtproto2-cloud-chat.spthy

# Debug lemmas
CLOUD_CHAT_DEBUG += $(SRC_DIR)/$(DEBUG_DIR)/mtproto2-cloud-chat.spthy
CLOUD_CHAT_DEBUG += $(SRC_DIR)/epilogue.spthy

# Lemmas
CLOUD_CHAT_LEMMAS += $(SRC_DIR)/$(LEMMAS_DIR)/$(CLOUD_CHAT)/secrecy.spthy
CLOUD_CHAT_LEMMAS += $(SRC_DIR)/$(LEMMAS_DIR)/$(CLOUD_CHAT)/kci.spthy
CLOUD_CHAT_LEMMAS += $(SRC_DIR)/epilogue.spthy

# Observational equivalence lemmas
CLOUD_CHAT_DIFF_LEMMAS  = $(SRC_DIR)/$(LEMMAS_DIR)/$(AUTH)/key-strong-secrecy.spthy
CLOUD_CHAT_DIFF_LEMMAS += $(SRC_DIR)/$(LEMMAS_DIR)/$(AUTH)/nk-strong-secrecy.spthy
CLOUD_CHAT_DIFF_LEMMAS += $(SRC_DIR)/epilogue.spthy


########################################################
# Secret chat protocol                                 #
########################################################
SECRET_CHAT         = secret-chat
SECRET_CHAT_UTT     = $(UTT_DIR)/secret_chat.json
SECRET_CHAT_UTT_DBG = $(UTT_DIR)/secret_chat_dbg.json

# Protocol definition
SECRET_CHAT_LIB  = $(SRC_DIR)/preamble.spthy
SECRET_CHAT_LIB += $(SRC_DIR)/mtproto2-common.spthy
SECRET_CHAT_LIB += $(SRC_DIR)/mtproto2-encryption/$(ENC)/mtproto2-encryption-common.spthy
SECRET_CHAT_LIB += $(SRC_DIR)/mtproto2-secret-chat.spthy

# Debug lemmas
SECRET_CHAT_DEBUG  = $(SRC_DIR)/$(DEBUG_DIR)/mtproto2-secret-chat.spthy
SECRET_CHAT_DEBUG += $(SRC_DIR)/epilogue.spthy

# Lemmas
SECRET_CHAT_LEMMAS  = $(SRC_DIR)/$(LEMMAS_DIR)/$(SECRET_CHAT)/authentication.spthy
SECRET_CHAT_LEMMAS += $(SRC_DIR)/$(LEMMAS_DIR)/$(SECRET_CHAT)/chat-secrecy.spthy
SECRET_CHAT_LEMMAS += $(SRC_DIR)/epilogue.spthy

# Observational equivalence lemmas
SECRET_CHAT_DIFF_LEMMAS  = $(SRC_DIR)/$(LEMMAS_DIR)/$(SECRET_CHAT)/ror-exponent.spthy
SECRET_CHAT_DIFF_LEMMAS  = $(SRC_DIR)/$(LEMMAS_DIR)/$(SECRET_CHAT)/ror-msg.spthy
SECRET_CHAT_DIFF_LEMMAS  = $(SRC_DIR)/$(LEMMAS_DIR)/$(SECRET_CHAT)/ror-session-key.spthy
SECRET_CHAT_DIFF_LEMMAS += $(SRC_DIR)/epilogue.spthy


########################################################
# Rekeying protocol                                    #
########################################################
REKEYING         = rekeying
REKEYING_UTT     = $(UTT_DIR)/rekeying.json
REKEYING_UTT_DBG = $(UTT_DIR)/rekeying_dbg.json

# Protocol definition
REKEYING_LIB  = $(SRC_DIR)/preamble.spthy
REKEYING_LIB += $(SRC_DIR)/mtproto2-common.spthy
REKEYING_LIB += $(SRC_DIR)/mtproto2-encryption/$(ENC)/mtproto2-encryption-common.spthy
REKEYING_LIB += $(SRC_DIR)/mtproto2-rekeying.spthy

# Debug lemmas
REKEYING_DEBUG  = $(SRC_DIR)/$(DEBUG_DIR)/mtproto2-rekeying.spthy
REKEYING_DEBUG += $(SRC_DIR)/epilogue.spthy

# Lemmas
REKEYING_LEMMAS  = $(SRC_DIR)/$(LEMMAS_DIR)/$(REKEYING)/agreement.spthy
REKEYING_LEMMAS += $(SRC_DIR)/$(LEMMAS_DIR)/$(REKEYING)/secrecy.spthy
REKEYING_LEMMAS += $(SRC_DIR)/$(LEMMAS_DIR)/$(REKEYING)/authentication.spthy
REKEYING_LEMMAS += $(SRC_DIR)/epilogue.spthy

# Observational equivalence lemmas
REKEYING_DIFF_LEMMAS += $(SRC_DIR)/epilogue.spthy


########################################################
# UT-tamarin configuration                             #
########################################################
UTT_EXEC  := uttamarin 
UTT_FLAGS  = 


########################################################
# Make rules                                           #
########################################################
# Run everything (but diff lemmas), including tests
.PHONY: all
all:	security debug

# Run security lemmas only
.PHONY: security
security:	auth cloud-chat secret-chat rekeying

# Run debug lemmas only
.PHONY: debug
debug: 		auth-dbg cloud-chat-dbg secret-chat-dbg rekeying-dbg

#---------------------------------------#
# Authorization protocol                #
#---------------------------------------#
.PHONY: auth
auth: 	$(AUTH_FILE)
	cat $(AUTH_LEMMAS) >> $(AUTH_FILE)
	$(UTT_EXEC) $(UTT_FLAGS) -c $(AUTH_UTT) $(AUTH_FILE)

.PHONY: auth-dbg
auth-dbg: 	$(AUTH_FILE)
	cat $(AUTH_DEBUG) >> $(AUTH_FILE)
	$(UTT_EXEC) $(UTT_FLAGS) -c $(AUTH_UTT_DBG) $(AUTH_FILE)

.PHONY: auth-diff
auth-diff:    $(AUTH_FILE)
	cat $(AUTH_DIFF_LEMMAS) >> $(AUTH_FILE)
	$(TAMARIN) interactive $(AUTH_FILE) $(TAMARIN_FLAGS) --diff

# This is also a phony target as it gets modified by other rules
.PHONY: $(AUTH_FILE)
$(AUTH_FILE):
	cat $(AUTH_LIB) > $(AUTH_FILE)

#---------------------------------------#
# Cloud chat protocol                   #
#---------------------------------------#
.PHONY: cloud-chat
cloud-chat: 	$(CLOUD_CHAT_FILE)
	cat $(CLOUD_CHAT_LEMMAS) >> $(CLOUD_CHAT_FILE)
	$(UTT_EXEC) $(UTT_FLAGS) -c $(CLOUD_CHAT_UTT) $(CLOUD_CHAT_FILE)

.PHONY: cloud-chat-dbg
cloud-chat-dbg: 	$(CLOUD_CHAT_FILE)
	cat $(CLOUD_CHAT_DEBUG) >> $(CLOUD_CHAT_FILE)
	$(UTT_EXEC) $(UTT_FLAGS) -c $(CLOUD_CHAT_UTT_DBG) $(CLOUD_CHAT_FILE)

.PHONY: cloud-chat-diff
cloud-chat-diff:    $(CLOUD_CHAT_FILE)
	cat $(CLOUD_CHAT_DIFF_LEMMAS) >> $(CLOUD_CHAT_FILE)
	$(TAMARIN) interactive $(CLOUD_CHAT_FILE) $(TAMARIN_FLAGS) --diff

# This is also a phony target as it gets modified by other rules
.PHONY: $(CLOUD_CHAT_FILE)
$(CLOUD_CHAT_FILE):
	cat $(CLOUD_CHAT_LIB) > $(CLOUD_CHAT_FILE)

#---------------------------------------#
# Secret chat protocol                  #
#---------------------------------------#
.PHONY: secret-chat
secret-chat:	$(SECRET_CHAT_FILE)
	cat $(SECRET_CHAT_LEMMAS) >> $(SECRET_CHAT_FILE) 
	$(UTT_EXEC) $(UTT_FLAGS) -c $(SECRET_CHAT_UTT) $(SECRET_CHAT_FILE)

.PHONY: secret-chat-dbg
secret-chat-dbg: 	$(SECRET_CHAT_FILE)
	cat $(SECRET_CHAT_DEBUG) >> $(SECRET_CHAT_FILE)
	$(UTT_EXEC) $(UTT_FLAGS) -c $(SECRET_CHAT_UTT_DBG) $(SECRET_CHAT_FILE)

.PHONY: secret-chat-diff
secret-chat-diff:    $(SECRET_CHAT_FILE)
	cat $(SECRET_CHAT_DIFF_LEMMAS) >> $(SECRET_CHAT_FILE)
	$(TAMARIN) interactive $(SECRET_CHAT_FILE) $(TAMARIN_FLAGS) --diff

# This is also a phony target as it gets modified by other rules
.PHONY: $(SECRET_CHAT_FILE)
$(SECRET_CHAT_FILE):
	cat $(SECRET_CHAT_LIB) > $(SECRET_CHAT_FILE)

#---------------------------------------#
# Rekeying protocol                     #
#---------------------------------------#
.PHONY: rekeying 
rekeying:	$(REKEYING_FILE)
	cat $(REKEYING_LEMMAS) >> $(REKEYING_FILE) 
	$(UTT_EXEC) $(UTT_FLAGS) -c $(REKEYING_UTT) $(REKEYING_FILE)

.PHONY: rekeying-dbg
rekeying-dbg: 	$(REKEYING_FILE)
	cat $(REKEYING_DEBUG) >> $(REKEYING_FILE)
	$(UTT_EXEC) $(UTT_FLAGS) -c $(REKEYING_UTT_DBG) $(REKEYING_FILE)

.PHONY: rekeying-diff
rekeying-diff:    $(REKEYING_FILE)
	cat $(REKEYING_DIFF_LEMMAS) >> $(REKEYING_FILE)
	$(TAMARIN) interactive $(REKEYING_FILE) $(TAMARIN_FLAGS) --diff

# This is also a phony target as it gets modified by other rules
.PHONY: $(REKEYING_FILE)
$(REKEYING_FILE):
	cat $(REKEYING_LIB) > $(REKEYING_FILE)

#---------------------------------------#
# Cleanup                               #
#---------------------------------------#
.PHONY: clean
clean:
	rm -f client_session_key.aes
	rm -f $(AUTH_FILE)
	rm -f $(CLOUD_CHAT_FILE)
	rm -f $(SECRET_CHAT_FILE)
	rm -f $(REKEYING_FILE)
