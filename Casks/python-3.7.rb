cask 'python-3.7' do
  version '3.7.5'
  sha256 'e26580e6324c30325c0eeeb8a1d7f5813575443d7fbddfe02c737fbee3fdb137'

  url "https://www.python.org/ftp/python/#{version}/python-#{version}-macosx10.9.pkg"
  name 'Python 3.7'
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

  caveats 'You can run "ln -s /Library/Frameworks/Python.framework/Versions'\
          "/#{version.slice(%r{\d+\.\d+})} ~/.pyenv/versions/"\
          "#{version.slice(%r{\d+\.\d+})}\" to make Python #{version.slice(%r{\d+\.\d+})}"\
          'available to pyenv.'
end
