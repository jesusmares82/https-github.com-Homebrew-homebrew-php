require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Memcache < AbstractPhp70Extension
  init
  desc "Memcache PHP extension"
  homepage "https://github.com/websupport-sk/pecl-memcache"
  url "https://github.com/websupport-sk/pecl-memcache/archive/4991c2fff22d00dc81014cc92d2da7077ef4bc86.tar.gz"
  version "3.0.9.20160311"
  sha256 "498ae2f3fde66b471eb8662efedfe5cb2f89f5fff725791ffddbcc7d94b7bf21"
  head "https://github.com/websupport-sk/pecl-memcache.git", :branch => "NON_BLOCKING_IO_php7"

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/memcache.so"
    write_config_file if build.with? "config-file"
  end
end
