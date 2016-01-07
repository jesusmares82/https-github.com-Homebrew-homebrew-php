require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pcntl < AbstractPhp70Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  bottle do
    cellar :any_skip_relocation
    revision 10
    sha256 "9ed5cb1349da76cdff1fa7ce53b8301bd8765027f3cacdb0201d270c9162aebe" => :el_capitan
    sha256 "8987776f9bda3ffd3b0509480f2680b67711d79d68e2ba3e6e546969c3e06a64" => :yosemite
    sha256 "93f41ed66fb5e03156286bd77bcecd6204b0277d586c2ffa84d18c9e18df2489" => :mavericks
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


