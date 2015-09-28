require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Libevent < AbstractPhp53Extension
  init
  homepage "https://pecl.php.net/package/libevent"
  url "https://pecl.php.net/get/libevent-0.0.5.tgz"
  sha256 "04c6ebba72a70694a68141a897e347a7f23e57117bffb80ac21e524529b6af78"
  head "http://svn.php.net/repository/pecl/libevent/trunk/"

  bottle do
    sha256 "bf02921c8ebe55c322626967d7f63d054b39813f635bfc58d5a2b499b483ebc5" => :el_capitan
    sha256 "6323ea35ab2cf4a4037c449bfce1a326a6f939ef9f86c30b59e40b4cba6708b6" => :yosemite
    sha256 "a91bcebe9e0b9ec13c3badc36397c1b63bed688d94945b7a52c02e4d8bdeddc9" => :mavericks
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
