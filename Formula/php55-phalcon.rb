require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Phalcon < AbstractPhp55Extension
  init
  desc "A full-stack PHP framework"
  homepage "http://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/phalcon-v2.0.10.tar.gz"
  sha256 "59fbe5bdee7a955ecb1f0cd8bb4c942e33105080302f239363aa3941e9e52172"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "383cbf82cb0c7898e890224be31bcd415a8b14b038849c9b70a8af0f7a871b70" => :el_capitan
    sha256 "7763cef0c3fbfc0c219745ea1597c28295607cbded384264ebd16a4f58bd09ea" => :yosemite
    sha256 "57e1cebddf269cdfc13e9f9d80ac58d233a0f90bbf458f287408ab5bdabdf7ee" => :mavericks
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
