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
#include "person.hpp"
using std::string;
using cpp::Person;

MODULE = CPP::Person    PACKAGE = CPP::Person

PROTOTYPES: DISABLE

=pod

Person::Person ではなく Person::new() と宣言
おそらく // や /* */ のコメントは XS セクションでは使えない

=cut

Person*
Person::new(string name, int age)

=pod

Person::~Person ではなく Person::DESTROY() と宣言

=cut

void
Person::DESTROY()

string
Person::introduce()

=pod

自分で method の定義もできる

=cut

void
double_age(...)
PPCODE:
{
  if (items != 1) {
    croak("Bad argument count: %d", items);
  }
  Person* THIS;
  if (SvROK(ST(0))) {
    THIS = (Person *)SvIV((SV*)SvRV( ST(0) ));
  } else {
    warn( "CPP::Person::introduce() -- THIS is not an SV reference" );
    XSRETURN_UNDEF;
  }
  IV d = THIS->getAge() * 2;
  XPUSHs(sv_2mortal(newSViv(d)));
  XSRETURN(1);
}
