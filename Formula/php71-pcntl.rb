require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Pcntl < AbstractPhp71Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  revision 7

  bottle do
    cellar :any_skip_relocation
    sha256 "194974dafc2189f8a33493af049e42c9ce79ebdc1b588e9be26fccf1ec754d55" => :sierra
    sha256 "44fdc45331b957c9d52bfc44e71cc5733b5a80e10023104227b4c92e3e005aa3" => :el_capitan
    sha256 "e9c89a9629f01dc213d503f9fd792fdca789ae2a82fc1656f2d75a11a6939e0c" => :yosemite
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
