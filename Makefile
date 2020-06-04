
CC=gcc
CPP_FLAGS= -Wall -Werror -Wno-unused -Wno-format-zero-length -g
C_FLAGS= 
LD_FLAGS= -lefence 

bin = m001 m002 m003 m004 m005 m006 m007 m008 m009 m010 m011 m012

all : $(bin)

$(bin) : % : %.o
	$(CC) $(LD_FLAGS) $(LDFLAGS) $< -o $@

%.o : %.c
	$(CC) -c $(CPP_FLAGS) $(C_FLAGS) $(CPPFLAGS) $(CFLAGS) $< -o $@

.PHONY: clean

clean:
	rm -f $(bin) *.o *~ $(bin:m%=mt%) $(bin:m%=mt%.c) $(bin:m%=t%.c) $(bin:m%=p%.c)

##
## Test user's functions by calling them from the original main function.
##

# For each user program m* we build the binary test program mt*

bintest : $(bin:m%=mt%)

# To build the binary test program mt* we link
# mt*.o having the user functions modified by the programmer agins
# t*.o  having the unaltered main function copied from the template

$(bin:m%=mt%) : mt% : mt%.o t%.o
	$(CC) $(LD_FLAGS) $(LDFLAGS) $^ -o $@

# How to fetch original pristine templates

RAWURL=https://raw.githubusercontent.com/exercise-template/cprog02/master

p%.c :
	wget -O - $(RAWURL)/$(@:p%.c=m%.c) > $@

# Make a modified copy of pristine template file having weak main

mt%.c : p%.c
	perl -pe 's/^ *([A-Za-z_][A-Za-z0-9_]*)\h+(main*\h*\(.*\))/__attribute__\(\(weak\)\) \1 \2 /g' $< > $@

# Make a modified copy of user-file file heaing weak user functions 

t%.c : m%.c
	perl -pe 's/^ *([A-Za-z_][A-Za-z0-9_]*)\h+(?!main)([A-Za-z_][A-Za-z0-9_]*\h*\(.*\))/__attribute__\(\(weak\)\) \1 \2 /g' $< > $@



