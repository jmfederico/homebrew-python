cask 'python-3.9' do
  version '3.9.0a6'
  sha256 'fa4cd2138d38a1bea0c6e654ae4621a7b8e1958f9ee71f890e92aa19b59ba775'

  url "https://www.python.org/ftp/python/#{version.slice(%r{\d+\.\d+\.\d+})}/python-#{version}-macosx10.9.pkg"
  name 'Python 3.9'
  homepage 'https://www.python.org/'

  pkg "python-#{version}-macosx10.9.pkg",
      choices: [
                 {
                   'choiceIdentifier' => "org.python.Python.PythonUnixTools-#{version.slice(%r{\d+\.\d+})}",
                   'choiceAttribute'  => 'selected',
                   'attributeSetting' => 0,
                 },
                 {
                   'choiceIdentifier' => "org.python.Python.PythonProfileChanges-#{version.slice(%r{\d+\.\d+})}",
                   'choiceAttribute'  => 'selected',
                   'attributeSetting' => 0,
                 },
               ]

  postflight do
    system_command "/Applications/Python #{version.slice(%r{\d+\.\d+})}/Install Certificates.command",
                   env: { 'PIP_REQUIRE_VIRTUALENV' => 'no' }
  end

  uninstall pkgutil: [
                       "org.python.Python.PythonFramework-#{version.slice(%r{\d+\.\d+})}",
                       "org.python.Python.PythonApplications-#{version.slice(%r{\d+\.\d+})}",
                       "org.python.Python.PythonDocumentation-#{version.slice(%r{\d+\.\d+})}",
                     ],
            delete:  [
                       "/Library/Frameworks/Python.framework/Versions/#{version.slice(%r{\d+\.\d+})}",
                       "/Applications/Python #{version.slice(%r{\d+\.\d+})}",
                     ]

  zap delete: "~/Library/Python/#{version.slice(%r{\d+\.\d+})}"

  caveats do
    pv = version.slice(%r{\d+\.\d+})
    puts <<~EOS
      To make Python #{pv} available to pyenv:
        ln -s /Library/Frameworks/Python.framework/Versions/#{pv} ~/.pyenv/versions/#{pv}

      If you use pyenv, do not add this formula bin directory to your PATH.
    EOS
    path_environment_variable "/Library/Frameworks/Python.framework/Versions/#{pv}/bin"
  end
end
