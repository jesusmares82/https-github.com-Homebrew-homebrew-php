require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pcntl < AbstractPhp70Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  revision 5

  bottle do
    cellar :any_skip_relocation
    sha256 "bcf40d58312245db405e1324a51cf0b6afdd8e60edb236fa0c9fd5afe4deecbc" => :sierra
    sha256 "1fce55e02fd755ca014d0448ae37fcefbb8cc4afd30a877417d443695dd27f91" => :el_capitan
    sha256 "33ca7856a144ab4da40bff6c7d8fc1fd5f582ccacbac9baa168a071cf59961a1" => :yosemite
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
