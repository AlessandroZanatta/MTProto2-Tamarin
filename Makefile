.POSIX:
.SUFFIXES:

SHELL         = /bin/sh

# Directories
LIB           = ./mtproto2.spthy
LIB_DIR       = ./libsrc
LEMMAS_DIR    = ./lemmas
ENC           = model2
DEBUG_DIR     = debug

# Sources
LIB_SRC       = $(LIB_DIR)/preamble.spthy
LIB_SRC      += $(LIB_DIR)/mtproto2-common.spthy

# Debug
DEBUG_SRC     = $(LIB_DIR)/$(DEBUG_DIR)/mtproto2-common.spthy
DEBUG_SRC    += $(LIB_DIR)/epilogue.spthy

# Security properties
# LEMMAS_SRC    = $(LEMMAS_DIR)
LEMMAS_SRC   += $(LIB_DIR)/epilogue.spthy

# Run
UTT_EXEC     := uttamarin 
UTT_CONF      = ./utt_config.json
UTT_CONF_DBG  = ./utt_config_dbg.json 
UTT_TIMEOUT   = 10
UTT_OUT       = ./out/utt_output.txt
UTT_OUT_DBG   = ./out/utt_output_dbg.txt
UTT_FLAGS     = -t $(UTT_TIMEOUT)


.PHONY: run
run: 	$(LIB)
	cat $(LEMMAS_SRC) >> $(LIB)
	$(UTT_EXEC) $(UTT_FLAGS) -c $(UTT_CONF) -o $(UTT_OUT) $(LIB)

.PHONY: debug
debug: 	$(LIB)
	cat $(DEBUG_SRC) >> $(LIB)
	$(UTT_EXEC) $(UTT_FLAGS) -c $(UTT_CONF_DBG) -o $(UTT_OUT_DBG) $(LIB)

.PHONY: $(LIB)
$(LIB):
	cat $(LIB_SRC) > $(LIB)

.PHONY: clean
clean:
	rm -f $(LIB)
	rm -f $(UTT_OUT)
	rm -f $(UTT_OUT_DBG)
