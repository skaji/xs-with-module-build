#ifdef __cplusplus
extern "C" {
#endif

#define PERL_NO_GET_CONTEXT /* we want efficiency */
#include <EXTERN.h>
#include <perl.h>
#include <XSUB.h>

#ifdef __cplusplus
} /* extern "C" */
#endif

#define NEED_newSVpvn_flags
#include "ppport.h"

#undef do_open
#undef do_close
#include <string>
#include <sstream>

MODULE = CPP    PACKAGE = CPP

PROTOTYPES: DISABLE

void
hello(...)
PPCODE:
{
  if (items != 1) { croak("hello() needs 1 argument"); }
  STRLEN len;
  char* p = SvPV(ST(0), len);
  std::string str(p, len);
  std::stringstream stream;
  stream << "Hello " << str << "!";
  SV* r = newSVpvn(stream.str().c_str(), stream.str().size());
  XPUSHs(sv_2mortal(r));
  XSRETURN(1);
}
