require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phing < AbstractPhpPhar
  init
  desc "Ant-like build tool for PHP"
  homepage "https://www.phing.info"
  url "https://www.phing.info/get/phing-2.16.0.phar"
  sha256 "4700f89be74332b83d9a51f7d867b21530b1ef019258ae6a050a9f9b35db11d5"

  bottle do
    cellar :any_skip_relocation
    sha256 "0e3e0bd42733e37b15db41518788939a29783f527c24d96ea508b13aa08e8fc6" => :sierra
    sha256 "0e3e0bd42733e37b15db41518788939a29783f527c24d96ea508b13aa08e8fc6" => :el_capitan
    sha256 "0e3e0bd42733e37b15db41518788939a29783f527c24d96ea508b13aa08e8fc6" => :yosemite
  end

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
