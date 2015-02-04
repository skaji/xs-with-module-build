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

MODULE = Callback    PACKAGE = Callback

PROTOTYPES: DISABLE

void
do_callback(...)
PPCODE:
{
  if (items != 2) {
    croak("failed");
  }
  SV* callback = ST(0);
  SV* arg = ST(1);

  // XXX need ENTER, SAVETMPS, FREETMPS, LEAVE?
  // ENTER;
  // SAVETMPS;

  PUSHMARK(SP);
  XPUSHs(arg);
  PUTBACK;
  int c = call_sv(callback, G_SCALAR);
  SPAGAIN;
  SV* out = newSVsv(POPs);
  PUTBACK;

  // FREETMPS;
  // LEAVE;

  XPUSHs(sv_2mortal(out));
  XSRETURN(1);
}
