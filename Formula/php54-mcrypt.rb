require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Mcrypt < AbstractPhp54Extension
  init
  homepage "http://php.net/manual/en/book.mcrypt.php"
  url      PHP_SRC_TARBALL
  sha256   PHP_CHECKSUM[:sha256]
  version  PHP_VERSION

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "7a1656068162a22612633dfa74d6a9fd53f7f5911374a442af3f109c528020e0" => :yosemite
    sha256 "a9fa29d0f4e6dc40b74aaf8b5e2230975e3aea35ff1a1c5324bacffa6b3aab95" => :mavericks
    sha256 "073ef13627b6a66a19a348cbf648270c8ac5a04541ad949c3db5466318c30494" => :mountain_lion
  end

  depends_on "mcrypt"

  def install
    Dir.chdir "ext/mcrypt"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-mcrypt=#{Formula['mcrypt'].opt_prefix}"
    system "make"
    prefix.install "modules/mcrypt.so"
    write_config_file if build.with? "config-file"
  end
end
