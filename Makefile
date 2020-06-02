
CC=gcc
CPP_FLAGS= -Wall -Werror -Wno-unused -Wno-format-zero-length
C_FLAGS=
LD_FLAGS=

bin = m001 m002 m003 m004 m005 m006 m007 m008 m009 m010 m011 m012

all : $(bin)

$(bin) : % : %.o
	$(CC) $(LD_FLAGS) $(LDFLAGS) $< -o $@

%.o : %.c
	$(CC) -c $(CPP_FLAGS) $(C_FLAGS) $(CPPFLAGS) $(CFLAGS) $< -o $@

.PHONY: clean

clean:
	rm -f $(bin) *.o *~


