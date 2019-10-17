cask 'python-3.8' do
  version '3.8.0'
  sha256 '30961fe060da9dc5afdc4e789a57fe9bcc0d20244474e9f095d7bfc89d2e1869'

  url "https://www.python.org/ftp/python/#{version}/python-#{version}-macosx10.9.pkg"
  name 'Python 3.8'
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
