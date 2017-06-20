require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Pcntl < AbstractPhp71Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  revision 13

  bottle do
    cellar :any_skip_relocation
    sha256 "9374d4958e13bf506bd103a74e29896e48d0628e6ceeb68e8a13a030dd12e411" => :sierra
    sha256 "f51554d311712fc194e6ddef370fc5ce95fe6c9c1cfeb8bc60cd25ea3c626bf7" => :el_capitan
    sha256 "ff04641727dca31549f5adf6febc889dcdf2bce3652427ad9d90eef47b649df1" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  def install
    Dir.chdir "ext/pcntl"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking"
    system "make"
    prefix.install "modules/pcntl.so"
    write_config_file if build.with? "config-file"
  end
end
