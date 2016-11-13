require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Pcntl < AbstractPhp71Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  revision 6

  bottle do
    cellar :any_skip_relocation
    sha256 "9221456b80c8f302604e78d836629d1be3365b72be7f4a2cbba26c7fc2998de3" => :sierra
    sha256 "7194e056d6432b1bccf8ba72c716a8b53c7982b4c64fb41d7a3651ce2edb5c2a" => :el_capitan
    sha256 "a225352e0f0eea9257ae93f5a3684d2ef384883a388a84b878d2a6e3fe680034" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  def install
    Dir.chdir "ext/pcntl"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking"
    system "make"
    prefix.install "modules/pcntl.so"
    write_config_file if build.with? "config-file"
  end
end
