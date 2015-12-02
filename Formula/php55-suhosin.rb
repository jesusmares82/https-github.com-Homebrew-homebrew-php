require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Suhosin < AbstractPhp55Extension
  init
  desc "Suhosin is an advanced protection system for PHP installations."
  homepage "http://suhosin.org/stories/index.html"
  url "https://github.com/stefanesser/suhosin/archive/0.9.37.1.tar.gz"
  sha256 "322ba104a17196bae63d39404da103fd011b09fde0f02484dc44366511c586ba"
  head "https://github.com/stefanesser/suhosin.git"

  bottle do
    sha256 "c9e52595bbeada891f9d66b75d1f900a7cbc87d6009d22c77d4257bf1006ad8a" => :yosemite
    sha256 "a8b1b78b4893de51c1fd82f627e4bd9d9820602bcb7eac22dccaf5a7b8ab1175" => :mavericks
    sha256 "ee9f1646f2edd9aa3dde0d029bd1e794c58749807cdb1ffc7bf520d390bb7fe8" => :mountain_lion
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/suhosin.so"
    write_config_file if build.with? "config-file"
  end
end
