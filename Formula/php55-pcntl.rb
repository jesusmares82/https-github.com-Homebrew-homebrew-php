require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Pcntl < AbstractPhp55Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    cellar :any_skip_relocation
    revision 7
    sha256 "918aa495849e1f2b1dfdabcacd5ba1888c9884a38335f7798ff322aa917cdd92" => :el_capitan
    sha256 "d126a967731703008510dd372e2d88cdfbe148b6f22e9e0ea78e94a6c0728871" => :yosemite
    sha256 "a63d94a227d161362ed6964ac187d0400a7f4d438381d057a69bc2503915e938" => :mavericks
  end

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





