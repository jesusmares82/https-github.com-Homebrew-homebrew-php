require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Pcntl < AbstractPhp71Extension
  init
  desc "Process Control support"
  homepage "https://php.net/manual/en/book.pcntl.php"
  revision 17

  bottle do
    cellar :any_skip_relocation
    sha256 "2ac4d476204e940daff8a9a6f6614a32a81f0d34262c039767243caa4fae851b" => :high_sierra
    sha256 "3ace6ecfde0c306558694e278168c97e28f7e8d1b2594060580475845781dcbe" => :sierra
    sha256 "215e32b59000ac4ba29973f71edd9b5dc5e391f6a34f910aee7eb2cada420613" => :el_capitan
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

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
