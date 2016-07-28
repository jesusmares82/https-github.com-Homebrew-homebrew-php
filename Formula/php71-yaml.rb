require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Yaml < AbstractPhp71Extension
  init
  desc "YAML-1.1 parser and emitter"
  homepage "https://pecl.php.net/package/yaml"
  url "https://pecl.php.net/get/yaml-2.0.0RC8.tgz"
  sha256 "44cab15d57b2fb8fa916ff9291059a34b0c3fa99298c2b08a5082f334613753a"
  head "https://github.com/php/pecl-file_formats-yaml.git", :branch => "php7"

  bottle do
    sha256 "951d6fe821938247b87d9fdca1b80a2b7df212483bfdf14c6090b522cdcef85b" => :el_capitan
    sha256 "186f7dd99eb7c2a688379979a2242a95fdd01868d67e89ebde27eb08dbba65b0" => :yosemite
    sha256 "793f8e8281fa16883a6f7c30b32990e5339371239984c2bddeb9fc3a9806f7fe" => :mavericks
  end

  depends_on "libyaml"

  def install
    Dir.chdir "yaml-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          "--with-yaml=#{Formula["libyaml"].opt_prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/yaml.so"
    write_config_file if build.with? "config-file"
  end
end
