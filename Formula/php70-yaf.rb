require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Yaf < AbstractPhp70Extension
  init
  desc "PHP framework similar to zend framework built as PHP extension"
  homepage "https://pecl.php.net/package/yaf"
  url "https://github.com/laruence/yaf/archive/yaf-3.0.3.tar.gz"
  sha256 "6761e636d055ec6756759185e91cf9fd42ca3f59e36172d7773b8052a1fb4887"
  head "https://github.com/laruence/yaf.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "5634fb8c7478c0a152887344134f6fcc6da759fe0cdaefd9016aa134c8d7b5da" => :el_capitan
    sha256 "768821370e69deb296f787529f88deaf53caf868d8f46fed768b38a98b1fa62b" => :yosemite
    sha256 "6f53e8a1bcfe463635f99356b25efa6f9951b413abc3e6eb5b6f6390a2e2eb55" => :mavericks
  end

  depends_on "pcre"

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/yaf.so"
    write_config_file if build.with? "config-file"
  end
end
