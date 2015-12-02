require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Libevent < AbstractPhp55Extension
  init
  desc "This extension is a wrapper for the libevent event notification library."
  homepage "https://pecl.php.net/package/libevent"
  url "https://pecl.php.net/get/libevent-0.0.5.tgz"
  sha256 "04c6ebba72a70694a68141a897e347a7f23e57117bffb80ac21e524529b6af78"
  head "http://svn.php.net/repository/pecl/libevent/trunk/"

  bottle do
    sha256 "279cffd62048f3fce046c0cf82cb89cd29a0fbb0097921e0e5de1366f399bb33" => :el_capitan
    sha256 "18cbc97270e8f9e5a1dd1c5c56fca9b308a433315d355ab8ae8b2d0fa6d21939" => :yosemite
    sha256 "3764f607ddb45ea42e206f96cc82c881d0ffe9779aa0f45142fee285c25da6b3" => :mavericks
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
