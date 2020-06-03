
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
	rm -f $(bin) *.o *~ $(bin:m%=mt%) mt???.c m???.h $(bin:m%.c=m%.h)

## Probe

$(bin:m%=mt%) : mt% : mt%.o m%.o 
	$(CC) $(LD_FLAGS) $(LDFLAGS) -nostartfiles $^ -o $@

$(bin:m%=mt%.o) : mt%.o : mt%.c m%.h 
	$(CC) $(CPP_FLAGS) $(C_FLAGS) $(CPPFLAGS) $(CFLAGS) -include test.h -include m*.h -c $< -o $@

mt%.c : m%.c
	sed -r 's/^ *([a-z]+) ([a-z]+) *\(/\1 \2_test \(/g' $< > $@

$(bin:m%=m%.h) : m%.h : m%.c
	egrep  '^ *[a-z]+ [a-z]+ *\(.*\)' $< | sed -r 's/(.*\))/\1;/g' > $@
