require 'formula'

class Kibana < Formula
  homepage 'http://www.elasticsearch.org/overview/kibana/'
  version '4.0.1'
  url 'https://download.elasticsearch.org/kibana/kibana/kibana-4.0.1-darwin-x64.tar.gz'
  sha1 '7729aba3ac26ec21ffc4a7b60046b638b076aa4a'

	depends_on "elasticsearch" => :recommended
	depends_on "logstash" => :recommended

	skip_clean 'src'

  def install

		# remove windows specific files
    rm_f Dir["bin/*.bat"]

		prefix.install Dir['src']
		prefix.install Dir['node']

		# kibana configuration
		etc.install 'config/kibana.yml'

		# point to the kibana configuration 
		inreplace 'bin/kibana', 
			'"${DIR}/config/kibana.yml"', 
			etc/'kibana.yml'

		# install the binary
    bin.install 'bin/kibana'
  end

	def caveats; <<-EOS.undent
    Kibana configuration: #{etc}/kibana.yml
    Ensure 'elasticsearch' is running
    Execute 'kibana'
    Visit http://localhost:5601
    EOS
  end
end
