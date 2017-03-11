require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Pcntl < AbstractPhp56Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 3

  bottle do
    cellar :any_skip_relocation
    sha256 "e92190345056bedf58c506909a8c203888db024887e0034e0d92b7d54a1fac24" => :sierra
    sha256 "e7c15de87d8a8f1b5e287bedceb01c34a339d67452a997c8a1de8353d33e87de" => :el_capitan
    sha256 "66892bc7a7139051bf06860d8c42060869f446cb7ed8d1fd2ad568cd024a9b53" => :yosemite
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
