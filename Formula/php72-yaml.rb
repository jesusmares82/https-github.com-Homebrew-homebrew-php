require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Yaml < AbstractPhp72Extension
  init
  desc "YAML-1.1 parser and emitter"
  homepage "https://pecl.php.net/package/yaml"
  url "https://pecl.php.net/get/yaml-2.0.0.tgz"
  sha256 "ef13ff56c184290c025a522bf9ae2e1b3ecc8543c3a5161dd02adec90897a221"
  head "https://github.com/php/pecl-file_formats-yaml.git", :branch => "php7"

  bottle do
    sha256 "d97c1d04d2b16457a479a712aa7d087e70e945c21611a25ef41e290c7de7efa6" => :sierra
    sha256 "94035370d61343048445a6470dcc4667a1d86a2d154357d0c6960c29143c434b" => :el_capitan
    sha256 "9cbc0f5b9b84e787f75efabc5a96bba991f4e2da9d29ab2185cd7d9a27230ff6" => :yosemite
  end

  depends_on "libyaml"

  def install
    Dir.chdir "yaml-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          "--with-yaml=#{Formula["libyaml"].opt_prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/yaml.so"
    write_config_file if build.with? "config-file"
  end
end
