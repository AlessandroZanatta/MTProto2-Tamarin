.POSIX:
.SUFFIXES:

# SHELL        := env PATH=$(TAMARIN_DIR):$(PATH) /bin/sh
SHELL 		   := /bin/sh
TAMARIN         = tamarin-prover
TAMARIN_FLAGS   = --quit-on-warning 

# Output source files
AUTH_CLOUD_FILE  = ./mtproto2-authorization-cloudchat.spthy
SCHAT_REKEY_FILE = ./mtproto2-secretchat-rekeying.spthy

# Directories
SRC_DIR         = ./src
LEMMAS_DIR      = lemmas
ENC             = model1
DEBUG_DIR       = debug
UTT_DIR         = ./utt_configs

##########################################
# Authorization and Cloud chat protocols #
##########################################
AUTH               = authorization
CLOUD_CHAT         = cloud-chat
AUTH_CLOUD_UTT     = $(UTT_DIR)/auth_cloud.json
AUTH_CLOUD_UTT_DBG = $(UTT_DIR)/auth_cloud_dbg.json

# Protocol definition
AUTH_CLOUD_LIB  = $(SRC_DIR)/preamble.spthy
AUTH_CLOUD_LIB += $(SRC_DIR)/mtproto2-common.spthy
AUTH_CLOUD_LIB += $(SRC_DIR)/mtproto2-encryption/$(ENC)/mtproto2-encryption-common.spthy
AUTH_CLOUD_LIB += $(SRC_DIR)/mtproto2-encryption/$(ENC)/mtproto2-encryption-authorization.spthy
AUTH_CLOUD_LIB += $(SRC_DIR)/mtproto2-encryption/$(ENC)/mtproto2-encryption-part-i.spthy
AUTH_CLOUD_LIB += $(SRC_DIR)/mtproto2-authorization.spthy
AUTH_CLOUD_LIB += $(SRC_DIR)/mtproto2-cloud-chat.spthy

# Debug lemmas
AUTH_CLOUD_DEBUG  = $(SRC_DIR)/$(DEBUG_DIR)/mtproto2-authorization.spthy
AUTH_CLOUD_DEBUG += $(SRC_DIR)/$(DEBUG_DIR)/mtproto2-cloud-chat.spthy
AUTH_CLOUD_DEBUG += $(SRC_DIR)/epilogue.spthy

# Lemmas
AUTH_CLOUD_LEMMAS  = $(SRC_DIR)/$(LEMMAS_DIR)/$(AUTH)/agreement.spthy
AUTH_CLOUD_LEMMAS += $(SRC_DIR)/$(LEMMAS_DIR)/$(AUTH)/authentication.spthy
AUTH_CLOUD_LEMMAS += $(SRC_DIR)/$(LEMMAS_DIR)/$(AUTH)/key-secrecy.spthy
AUTH_CLOUD_LEMMAS += $(SRC_DIR)/$(LEMMAS_DIR)/$(AUTH)/session.spthy
AUTH_CLOUD_LEMMAS += $(SRC_DIR)/$(LEMMAS_DIR)/$(CLOUD_CHAT)/secrecy.spthy
AUTH_CLOUD_LEMMAS += $(SRC_DIR)/$(LEMMAS_DIR)/$(CLOUD_CHAT)/kci.spthy
AUTH_CLOUD_LEMMAS += $(SRC_DIR)/epilogue.spthy

# Observational equivalence lemmas
AUTH_CLOUD_DIFF_LEMMAS  = $(SRC_DIR)/$(LEMMAS_DIR)/$(AUTH)/key-strong-secrecy.spthy
AUTH_CLOUD_DIFF_LEMMAS += $(SRC_DIR)/$(LEMMAS_DIR)/$(AUTH)/nk-strong-secrecy.spthy
AUTH_CLOUD_DIFF_LEMMAS += $(SRC_DIR)/epilogue.spthy

######################################
# Secret chat and rekeying protocols #
######################################
SECRET_CHAT         = secret-chat
REKEYING            = rekeying
SCHAT_REKEY_UTT     = $(UTT_DIR)/schat_rekey.json
SCHAT_REKEY_UTT_DBG = $(UTT_DIR)/schat_rekey_dbg.json

# Protocol definition
SCHAT_REKEY_LIB  = $(SRC_DIR)/preamble.spthy
SCHAT_REKEY_LIB += $(SRC_DIR)/mtproto2-common.spthy
SCHAT_REKEY_LIB += $(SRC_DIR)/mtproto2-encryption/$(ENC)/mtproto2-encryption-common.spthy
SCHAT_REKEY_LIB += $(SRC_DIR)/mtproto2-secret-chat.spthy

# Debug lemmas
SCHAT_REKEY_DEBUG  = $(SRC_DIR)/$(DEBUG_DIR)/mtproto2-secret-chat.spthy
SCHAT_REKEY_DEBUG += $(SRC_DIR)/epilogue.spthy

# Lemmas
SCHAT_REKEY_LEMMAS  = $(SRC_DIR)/$(LEMMAS_DIR)/$(SECRET_CHAT)/authentication.spthy
SCHAT_REKEY_LEMMAS += $(SRC_DIR)/epilogue.spthy

# Observational equivalence lemmas
SCHAT_REKEY_DIFF_LEMMAS  = $(SRC_DIR)/$(LEMMAS_DIR)/$(SECRET_CHAT)/ror_exponent.spthy
SCHAT_REKEY_DIFF_LEMMAS += $(SRC_DIR)/epilogue.spthy

############################
# UT-Tamarin configuration #
############################
UTT_EXEC  := uttamarin 
UTT_FLAGS  = 

##############
# Make rules #
##############

# Run everything (but diff lemmas), including tests
.PHONY: all
all:	security debug

# Run security lemmas only
.PHONY: security
security:	auth-cloud secret-rekey

# Run debug lemmas only
.PHONY: debug
debug: 		auth-cloud-dbg secret-rekey-dbg

#---------------------------------------#
# Authorization and cloud chat protocol #
#---------------------------------------#
.PHONY: auth-cloud
auth-cloud: 	$(AUTH_CLOUD_FILE)
	cat $(AUTH_CLOUD_LEMMAS) >> $(AUTH_CLOUD_FILE)
	$(UTT_EXEC) $(UTT_FLAGS) -c $(AUTH_CLOUD_UTT) $(AUTH_CLOUD_FILE)

.PHONY: auth-cloud-dbg
auth-cloud-dbg: 	$(AUTH_CLOUD_FILE)
	cat $(AUTH_CLOUD_DEBUG) >> $(AUTH_CLOUD_FILE)
	$(UTT_EXEC) $(UTT_FLAGS) -c $(AUTH_CLOUD_UTT_DBG) $(AUTH_CLOUD_FILE)

.PHONY: auth-cloud-diff
auth-cloud-diff:    $(AUTH_CLOUD_FILE)
	cat $(AUTH_CLOUD_DIFF_LEMMAS) >> $(AUTH_CLOUD_FILE)
	$(TAMARIN) interactive $(AUTH_CLOUD_FILE) $(TAMARIN_FLAGS) --diff

# This is also a phony target as it gets modified by other rules
.PHONY: $(AUTH_CLOUD_FILE)
$(AUTH_CLOUD_FILE):
	cat $(AUTH_CLOUD_LIB) > $(AUTH_CLOUD_FILE)

#-----------------------------------#
# Secret chat and rekeying protocol #
#-----------------------------------#
.PHONY: secret-rekey
secret-rekey:	$(SCHAT_REKEY_FILE)
	cat $(SCHAT_REKEY_LEMMAS) >> $(SCHAT_REKEY_FILE) 
	$(UTT_EXEC) $(UTT_FLAGS) -c $(SCHAT_REKEY_UTT) $(SCHAT_REKEY_FILE)

.PHONY: secret-rekey-dbg
secret-rekey-dbg: 	$(SCHAT_REKEY_FILE)
	cat $(SCHAT_REKEY_DEBUG) >> $(SCHAT_REKEY_FILE)
	$(UTT_EXEC) $(UTT_FLAGS) -c $(SCHAT_REKEY_UTT_DBG) $(SCHAT_REKEY_FILE)

.PHONY: secret-rekey-diff
secret-rekey-diff:    $(SCHAT_REKEY_FILE)
	cat $(SCHAT_REKEY_DIFF_LEMMAS) >> $(SCHAT_REKEY_FILE)
	$(TAMARIN) interactive $(SCHAT_REKEY_FILE) $(TAMARIN_FLAGS) --diff

# This is also a phony target as it gets modified by other rules
.PHONY: $(SCHAT_REKEY_FILE)
$(SCHAT_REKEY_FILE):
	cat $(SCHAT_REKEY_LIB) > $(SCHAT_REKEY_FILE)

#-------#
# Clean #
#-------#
.PHONY: clean
clean:
	rm -f client_session_key.aes
	rm -f $(SCHAT_REKEY_FILE)
	rm -f $(AUTH_CLOUD_FILE)
