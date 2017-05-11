require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Suhosin < AbstractPhp54Extension
  init
  desc "Suhosin is an advanced protection system for PHP installations."
  homepage "https://suhosin.org/stories/index.html"
  url "https://github.com/sektioneins/suhosin/archive/0.9.38.tar.gz"
  sha256 "c02d76c4e7ce777910a37c18181cb67fd9e90efe0107feab3de3131b5f89bcea"
  head "https://github.com/stefanesser/suhosin.git"

  bottle do
    sha256 "264fc0dbd8dd7a5ea69a35a3b0e7861dc14ded0691f7a1d38821fb72c508b4ef" => :yosemite
    sha256 "ee63d23d3ac6fca7d6a534923bf0ef08bcfdc73697ea06ef5baa7ba6f29b91da" => :mavericks
    sha256 "315bbfa4ebcc130ebbc0be2556c5cb32a27340a50da0e53810eb983c10ae8030" => :mountain_lion
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/suhosin.so"
    write_config_file if build.with? "config-file"
  end
end
