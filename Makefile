## Makefile - Build script
##
## Copyright 2020 - Monaco F. J. <monaco@usp.br>
##
## This program is distrubuted under the GNU General Public License
## version 3. For detailed information, please see companiong file LICENSING

# User targets:
# 
# make		   build all user programs (make all)
# make  m000	   build user program m000 from source m000.c
#
# make bin-test    build all test programs
# make mt000	   build program mt000 to test m000.c
#
# make clean-bin   delete what's been built by make (make all)
# make clean-test  delete what's been built by make bin-test 
# make clean	   delete everything that's been built but templates
# make clean-ref   delete template (reference) files
# make clean-all   delete everything that's been built
#
# make fetch-ref   delete and refetch all templates

CC=gcc
CPP_FLAGS= -Wall -g
C_FLAGS= 
LD_FLAGS= 

##
## Build user programs.
##

bin = m000 m001 m002 m003 m004 m005 m006 m007 m008 m009 m010 m011

all : $(bin)

$(bin) : % : %.o
	$(CC) $(LD_FLAGS) $(LDFLAGS) $< -o $@

%.o : %.c
	$(CC) -c $(CPP_FLAGS) $(C_FLAGS) $(CPPFLAGS) $(CFLAGS) $< -o $@

.PHONY: clean

clean-bin:
	rm -f $(bin) $(bin:%=%.o) 

clean: clean-bin clean-test

##
## Test user programs
##

# Rationale.
# Programming exercises consist in modifying user functions provided by the
# source code templates, which are then called from the program's main function.
# In order to test the solution we intend to build the program, execute the
# binary and perform an automate input-output comparison test. By this means
# it is, however, possible for programmers to make alternative implementations
# directly in the body of the main function, without calling the user function,
# which is not desirable for the didactic purpose of the exercises. Moreover,
# cheating is also not guaranteed to be prevented if the programmer, knowing
# the expected output, deliberately cause the main function to print it as a
# fixed string (even if the hack turns out more challenging than the very
# exercise itself, experience has shown that one should never underestimate
# a motivated geek programmer).
#
# In order to prevent such undesirable scenarios, what we do instead is to
# link the user function from the program modified by the user against the
# unchanged main function from the original template.

# For each user program m* we build the binary test program mt*

bin-test : $(bin:m%=mt%)


$(bin:m%=mt%) : mt% : mt%.o 
	$(CC) $(LD_FLAGS) $(LDFLAGS) $^ -o $@

$(bin:m%=mt%.c) : mt%.c : m%.c
	cp $< $@

$(bin:m%=mt%.o) : mt%.o : mt%.c 
	$(CC) -c $(CPP_FLAGS) $(C_FLAGS) $(CPPFLAGS) $(CFLAGS) $< -o $@

# Clean tests and auxiliary files

clean-test: 
	rm -f $(bin:m%=mt%)
	rm -f $(bin:m%=mt%.c) $(bin:m%=t%.c) $(bin:m%=t%.h)
	rm -f $(bin:m%=mt%.o) $(bin:m%=t%.o) $(bin:m%=p%.o)

clean-all: 
	make clean
	make clean-test
	make clean-ref

clean-ref:
	rm -f $(bin:m%=p%.c)

# Fetch all template (reference) files again


fetch-ref : clean-ref
	make allrefs

allrefs : $(bin:m%=p%.c)


