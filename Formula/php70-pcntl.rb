require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pcntl < AbstractPhp70Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  bottle do
    cellar :any_skip_relocation
    revision 9
    sha256 "cdb203af7c12cad63398f00cac309bad49792705f930a933994b971d5f962a31" => :el_capitan
    sha256 "2e5a919bf765d6eec0d4d458187d0766ce49d7878f90bf6f6d58b9c5b21be570" => :yosemite
    sha256 "66a44d080e311bf146871a0a8a089dc4af02119db04cfdd766007f36b0ab69ca" => :mavericks
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

