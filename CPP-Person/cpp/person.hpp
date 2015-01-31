#ifndef PERSON_HPP_
#define PERSON_HPP_

#include <string>

namespace cpp {
class Person {
private:
  std::string m_name;
  int m_age;
public:
  Person(std::string name, int age);
  ~Person();
  std::string introduce();
  int getAge();
};
}

#endif
