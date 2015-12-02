require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Libevent < AbstractPhp54Extension
  init
  desc "This extension is a wrapper for the libevent event notification library."
  homepage "https://pecl.php.net/package/libevent"
  url "https://pecl.php.net/get/libevent-0.0.5.tgz"
  sha256 "04c6ebba72a70694a68141a897e347a7f23e57117bffb80ac21e524529b6af78"
  head "http://svn.php.net/repository/pecl/libevent/trunk/"

  bottle do
    sha256 "873dea6699f2fea9ec281453eed998210431e8e3f86ceb36a2e3acd8ee27094c" => :el_capitan
    sha256 "f50d3ac51ae6e5215c525257e06a76cf524a6ef2d203a4b177f9c45eaf2d9164" => :yosemite
    sha256 "fd7b2bfe4855c42f14b7d87d1f9e5a8fcede987c3dadd526d5e530b69f220e15" => :mavericks
  end

  depends_on "libevent"

  def install
    Dir.chdir "libevent-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-libevent=#{Formula["libevent"].opt_prefix}"
    system "make"
    prefix.install "modules/libevent.so"
    write_config_file if build.with? "config-file"
  end
end
