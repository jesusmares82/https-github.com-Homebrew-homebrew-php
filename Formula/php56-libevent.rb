require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Libevent < AbstractPhp56Extension
  init
  homepage "https://pecl.php.net/package/libevent"
  url "https://pecl.php.net/get/libevent-0.0.5.tgz"
  sha256 "04c6ebba72a70694a68141a897e347a7f23e57117bffb80ac21e524529b6af78"
  head "http://svn.php.net/repository/pecl/libevent/trunk/"

  bottle do
    sha256 "f7fc86c1a7302c037729d611d7589569c047a51ee4d46733cc02755b368815ba" => :el_capitan
    sha256 "ab05194861ca3438b83b71bbf08fd549ac728de06f417fddd79fb7583ffb3f09" => :yosemite
    sha256 "54157777cb992844b0d7bd716d488722b9a56da0a29f70c3e8ce433b07df58ee" => :mavericks
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
