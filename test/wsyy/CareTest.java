package wsyy;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.junit.Test;

public class CareTest {
	@Test
	public void testExtraOpenID() {
		String x = "callback( {\"client_id\":\"YOUR_APPID\",\"openid\":\"YOUR_OPENID\"} );";
		Pattern p = Pattern.compile("callback();");
		Matcher matcher = p.matcher(x);
		if (matcher.find()) {
			String group = matcher.group(1);
			System.out.println(group);
		}

	}
}
