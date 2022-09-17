{ lib
, buildPythonPackage
, fetchPypi
, chardet
, html5lib
, lxml
, pytestCheckHook
, pythonOlder
, soupsieve
, sphinxHook
}:

buildPythonPackage rec {
  pname = "beautifulsoup4";
  version = "4.11.1";
  format = "setuptools";
  outputs = ["out" "doc"];

  disabled = pythonOlder "3.6";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-rZqlW2XvKAjrQF9Gz3Tff8twRNXLwmSH+W6y7y5DZpM=";
  };

  nativeBuildInputs = [
    sphinxHook
  ];

  propagatedBuildInputs = [
    chardet
    html5lib
    lxml
    soupsieve
  ];

  checkInputs = [
    pytestCheckHook
  ];

  disabledTests = [
    # IndexError: list index out of range
    "test_beautifulstonesoup_is_xml_parser"
    "test_parseOnlyThese_renamed_to_parse_only"
    "test_fromEncoding_renamed_to_from_encoding"
    "test_deprecated_member_access"
    "test_find_type_method_string"
    "test_soupstrainer_constructor_string"
  ];

  pythonImportsCheck = [
    "bs4"
  ];

  meta = with lib; {
    homepage = "http://crummy.com/software/BeautifulSoup/bs4/";
    description = "HTML and XML parser";
    license = licenses.mit;
    maintainers = with maintainers; [ domenkozar ];
  };
}
