require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Phalcon < AbstractPhp55Extension
  init
  homepage "http://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/phalcon-v2.0.2.tar.gz"
  sha256 "ed1d4cfa15c6bb2b0c80cbf63ad8e06fd8517e48413a7dc95c445409be350c84"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "58dbdc88c3e30ce22db7ea644ec83be49e40c5f2e654f9db78256d994ad3aeed" => :yosemite
    sha256 "1281e2443a598db4cfd3deaa8d33537dab623e33d4769f93d12df831b19156cf" => :mavericks
    sha256 "319ab50f217546f38cd910f8d8dbf47b9a7982b6f57f269da2aad1cb0bf9a5d6" => :mountain_lion
  end

  depends_on "pcre"

  def install
    if MacOS.prefer_64_bit?
      Dir.chdir "build/64bits"
    else
      Dir.chdir "build/32bits"
    end

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--enable-phalcon"
    system "make"
    prefix.install "modules/phalcon.so"
    write_config_file if build.with? "config-file"
  end
end
