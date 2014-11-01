CC=gcc
CFLAGS=-I. -Wall
OBJDIR=obj
BINDIR=bin

DIRS=$(OBJDIR) $(addprefix $(OBJDIR)/, GSM610 G72x) $(BINDIR)

AR=ar
ARFLAGS=cvq

LIBGSM_SOURCE_FILES=GSM610/add.c GSM610/code.c GSM610/decode.c GSM610/gsm_create.c \
        GSM610/gsm_decode.c GSM610/gsm_destroy.c GSM610/gsm_encode.c \
        GSM610/gsm_option.c GSM610/long_term.c GSM610/lpc.c GSM610/preprocess.c \
        GSM610/rpe.c GSM610/short_term.c GSM610/table.c

LIBG72X_SOURCE_FILES=G72x/g721.c G72x/g723_16.c G72x/g723_24.c G72x/g723_40.c G72x/g72x.c

LIBSNDFILE_SRC_FILES=common.c file_io.c command.c pcm.c ulaw.c alaw.c float32.c \
        double64.c ima_adpcm.c ms_adpcm.c gsm610.c dwvw.c vox_adpcm.c \
        interleave.c strings.c dither.c broadcast.c audio_detect.c \
        ima_oki_adpcm.c chunk.c ogg.c chanmap.c windows.c id3.c \
        sndfile.c aiff.c au.c avr.c caf.c dwd.c flac.c g72x.c htk.c ircam.c \
        macbinary3.c macos.c mat4.c mat5.c nist.c paf.c pvf.c raw.c rx2.c sd2.c \
        sds.c svx.c txw.c voc.c wve.c w64.c wav_w64.c wav.c xi.c mpc2k.c rf64.c \
        ogg_vorbis.c ogg_speex.c ogg_pcm.c

SOURCES=$(LIBSNDFILE_SRC_FILES) $(LIBGSM_SOURCE_FILES) $(LIBG72X_SOURCE_FILES)
OBJECTS=$(addprefix $(OBJDIR)/, $(SOURCES:.c=.o))
LIBRARY=$(addprefix $(BINDIR)/, libsndfile.a)

all: $(LIBRARY)

$(LIBRARY): $(OBJECTS)
	$(AR) $(ARFLAGS) $@ $(OBJECTS)

$(OBJDIR)/%.o: %.c $(DIRS)
	$(CC) $(CFLAGS) -c -o $@ $<

$(DIRS):
	mkdir -p $@

clean:
	rm -rf $(OBJDIR)
	rm -rf $(BINDIR)