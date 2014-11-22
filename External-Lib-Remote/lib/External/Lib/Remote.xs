#ifdef __cplusplus
extern "C" {
#endif

#define PERL_NO_GET_CONTEXT /* we want efficiency */
#include <EXTERN.h>
#include <perl.h>
#include <XSUB.h>
#include "add.h"

#ifdef __cplusplus
} /* extern "C" */
#endif

#define NEED_newSVpvn_flags
#include "ppport.h"

MODULE = External::Lib::Remote    PACKAGE = External::Lib::Remote

PROTOTYPES: DISABLE

void
xs_add(...)
PPCODE:
{
  if (items != 2) { croak("Invalid args"); }
  SV* a = ST(0);
  SV* b = ST(1);
  int c = add(SvIV(a), SvIV(b));
  XPUSHs(sv_2mortal(newSViv(c)));
  XSRETURN(1);
}
