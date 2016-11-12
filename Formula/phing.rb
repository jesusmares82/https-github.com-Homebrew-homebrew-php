require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phing < AbstractPhpPhar
  init
  desc "Ant-like build tool for PHP"
  homepage "https://www.phing.info"
  url "https://www.phing.info/get/phing-2.15.2.phar"
  sha256 "842ad05e71597263f795239487e8ed3b3f170ed7b757cc442cec61d9d413f220"

  def phar_file
    "phing-#{version}.phar"
  end

  test do
    (testpath/"build.xml").write <<-EOS.undent
    <?xml version="1.0" encoding="UTF-8"?>
    <project name="test" default="default">
      <target name="default">
        <echo msg="Test"/>
      </target>
    </project>
    EOS
    assert_match "[echo] Test", shell_output("#{bin}/phing")
  end
end
