# MTProto2 Mobile Protocol - Tamarin analysis

This a repository about the formal analysis of Telegram's MTProto2 Mobile Protocol.
This is part of my bachelor thesis. 

Formal analysis is conducted using [Tamarin-prover](https://github.com/tamarin-prover/tamarin-prover/).

## Structure

The repository follows this structure:

 - [src](src) - Tamarin-prover model sources
    - [debug](src/debug) - contains debug/reachability lemmas
    - [lemmas](src/lemmas) - contains security lemmas
    - [mtproto2-encryption/modelX](src/mtproto2-encryption) - contains cryptographic primitives definitions
    - `mtproto2-<protocol>.spthy` files contain the actual implementation of the protocol in Tamarin
 - [utt_configs](utt_configs) - configuration files. See [configuring](#configuring) section.


## Running

To run the scripts you need to have [Tamarin-prover](https://github.com/tamarin-prover/tamarin-prover/) executable in your path. See instructions on how to obtain a copy on the official website. You will also need to have [ut-tamarin](https://github.com/benjaminkiesl/ut_tamarin). You can clone the repository and follow [installation instructions](https://github.com/benjaminkiesl/ut_tamarin#installation). Now you're good to go!
 
You can execute security properties lemmas using `make security`. This will run the lemmas for all of the individual protocols. MTProto2.0 has been, in this analysis, decomposed in four main protocols:

 - Authorization protocol (auth)
 - Cloud chat protocol (cloud-chat)
 - Secret chat protocol (secret-chat)
 - Rekeying protocol (rekeying)

You can run security properties from a chosen protocol with `make <protocol>`, where `<protocol>` is one of the shorter names between parenthesis (see list above). 

Observational equivalence queries are also available using `make <protocol>-diff`, but these mostly do not work due to the complexity of the model and the high complexity of observational equivalence proofs.

## Debugging

You can launch debugging (mainly reachability) lemmas using `make <protocol>-dbg`.

## Configuring

In the [utt_configs](utt_configs) directory you can find configuration files for every protocol (both for security lemmas and debug/reachability). Configuration should be fairly intuitive, please refer to the [ut_tamarin configuration options](https://github.com/benjaminkiesl/ut_tamarin#specifying-configuration-options-of-ut-tamarin) for more details.

Note that most of the files are actually just the skeleton of an empty configuration and are kept for future usage only.
