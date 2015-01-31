#include "person.hpp"
#include <sstream>

using namespace std;
using namespace cpp;

Person::Person(string name, int age) : m_name(name), m_age(age) {}
Person::~Person() {}

string Person::introduce() {
  stringstream ss;
  ss << "My name is " << m_name
     << ", and I'm " << m_age << " year's old";
  return ss.str();
}

int Person::getAge() {
  return this->m_age;
}
