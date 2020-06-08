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
CPP_FLAGS= -Wall -Werror -Wno-unused -Wno-format-zero-length -g
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

# To build the binary test program mt000 we link
# t000.o   having the user functions modified by the programmer against
# mt000.o  having the unaltered main function copied from the template

$(bin:m%=mt%) : mt% : mt%.o t%.o
	$(CC) $(LD_FLAGS) $(LDFLAGS) $^ -o $@

# Source t000.c is a copy of the user modified program with function main
# marked with attribute 'weak', so that we can link t000.o against an object
# which already provides its own main function (mt000.o). Then, object t000.o
# is built using the standard %.o rule.

t%.c : m%.c
#	perl -pe 's/^ *([A-Za-z_][A-Za-z0-9_]*)\h+(main*\h*\(.*\))/__attribute__\(\(weak\)\) \1 \2 /g' $< > $@
	perl -pe 's/([A-Za-z_][A-Za-z0-9_]*(?<!define))[\h\n]+(main*\h*\(.*\))/__attribute__\(\(weak\)\) \1 \2 /g' $< > $@

# Source mt000.c is a modified copy of the pristine template p000.c from
# which user program mt000.c was created. File mt000.c has all its functions
# but main() renamed so that they do not conflict with those in the user
# program mt000.c.

$(bin:m%=mt%.c) : mt%.c : p%.c
#	perl -pe 's/^ *([A-Za-z_][A-Za-z0-9_]*)\h+(?!main)([A-Za-z_][A-Za-z0-9_]*)(\h*\(.*\))/\1 \2_off \3/g' $< > $@
	perl -pe 's/([A-Za-z_][A-Za-z0-9_]*(?<!define))[\h\n]+(?!main)([A-Za-z_][A-Za-z0-9_]*)(\h*\(.*\))/\1 \2_off \3/g' $< > $@

# To build mt%.o we need the headers of the functions in m%.c

$(bin:m%=t%.h): t%.h : m%.c
	perl -0777pe 's/\/\*(?:(?!\*\/).)*\*\/\n?//sg' $< | perl -ne 'printf if /[A-Za-z_][A-Za-z0-9_]*(?<!define)[\h\n]+((?!main)[A-Za-z_][A-Za-z0-9_]*\h*\(.*\))/' | perl -pe 's/(.*\(.*\))/\1;/g' > $@


$(bin:m%=mt%.o) : mt%.o : mt%.c t%.h
	$(CC) -include t$*.h -c $(CPP_FLAGS) $(C_FLAGS) $(CPPFLAGS) $(CFLAGS) $< -o $@

# In order to be sure that p000.c is in its pristine form and its main
# function is unmodified, we fetch the original templates from the repository.

RAWURL=https://raw.githubusercontent.com/exercise-template/cprog02/master

$(bin:m%=p%.c):
	wget -O - $(RAWURL)/$(@:p%.c=m%.c) > $@

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


