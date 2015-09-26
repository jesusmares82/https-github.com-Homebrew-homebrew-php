require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Twig < AbstractPhp55Extension
  init
  homepage "http://twig.sensiolabs.org/"
  url "https://github.com/twigphp/Twig/archive/v1.16.2.tar.gz"
  sha256 "891e0e8f8eeee10f67c84556c28258dc5a96f8ef83e9fee1fefa64cf6aee27ef"
  head "https://github.com/twigphp/Twig.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "e8c70b3f0851a6bc6b67c28e50f22d0a2dc7290e68e167342b83e6eacb2aec6f" => :el_capitan
    sha256 "19988627f1ad0e264e23b0ab76764ba20017ea7da817e8eb833aadb0f42bf3c1" => :yosemite
    sha256 "7e28a6899323ae813304c8fcd614e662099f7da0c61b217ffa3296aeba6fbeaa" => :mavericks
  end

  def install
    ENV.universal_binary if build.universal?

    Dir.chdir "ext/twig" do
      safe_phpize
      system "./configure", "--prefix=#{prefix}",
                            phpconfig
      system "make"
      prefix.install %w[modules/twig.so]
    end
    write_config_file if build.with? "config-file"
  end
end
