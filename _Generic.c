static void handle_unsigned_char( unsigned char x ){}
static void handle_signed_char( signed char x ){}
static void handle_unsigned_short( unsigned short x ){}
static void handle_short( short x ){}
static void handle_unsigned_int( unsigned int x ){}
static void handle_int( int x ){}
static void handle_unsigned_long( unsigned long x ){}
static void handle_long( long x ){}
static void handle_unsigned_long_long( unsigned long long x ){}
static void handle_long_long( long long x ){}
static void handle_float( float x ){}
static void handle_double( double x ){}
static void handle_unsigned_char_ptr( unsigned char *x ){}
static void handle_signed_char_ptr( signed char *x ){}
static void handle_unsigned_short_ptr( unsigned short *x ){}
static void handle_short_ptr( short *x ){}
static void handle_unsigned_int_ptr( unsigned int *x ){}
static void handle_int_ptr( int *x ){}
static void handle_unsigned_long_ptr( unsigned long *x ){}
static void handle_long_ptr( long *x ){}
static void handle_unsigned_long_long_ptr( unsigned long long *x ){}
static void handle_long_long_ptr( long long *x ){}
static void handle_float_ptr( float *x ){}
static void handle_double_ptr( double *x ){}

int main( void )
{
  int foo = 0;

  #define X                                              \
  (void)_Generic( foo,                                   \
    unsigned char: handle_unsigned_char,                 \
    signed char: handle_signed_char,                     \
    unsigned short: handle_unsigned_short,               \
    short: handle_short,                                 \
    unsigned int: handle_unsigned_int,                   \
    int: handle_int,                                     \
    unsigned long: handle_unsigned_long,                 \
    long: handle_long,                                   \
    unsigned long long: handle_unsigned_long_long,       \
    long long: handle_long_long,                         \
    float: handle_float,                                 \
    double: handle_double,                               \
    unsigned char *: handle_unsigned_char_ptr,           \
    signed char *: handle_signed_char_ptr,               \
    unsigned short *: handle_unsigned_short_ptr,         \
    short *: handle_short_ptr,                           \
    unsigned int *: handle_unsigned_int_ptr,             \
    int *: handle_int_ptr,                               \
    unsigned long *: handle_unsigned_long_ptr,           \
    long *: handle_long_ptr,                             \
    unsigned long long *: handle_unsigned_long_long_ptr, \
    long long *: handle_long_long_ptr,                   \
    float *: handle_float_ptr,                           \
    double *: handle_double_ptr                          \
  )( foo );                                              \

  #define X10 X X X X X X X X X X
  #define X100 X10 X10 X10 X10 X10 X10 X10 X10 X10 X10
  #define X1000 X100 X100 X100 X100 X100 X100 X100 X100 X100 X100
  #define X10000 X1000 X1000 X1000 X1000 X1000 X1000 X1000 X1000 X1000 X1000
  #define X100000 X10000 X10000 X10000 X10000 X10000 X10000 X10000 X10000 X10000 X10000

  X100000
}
