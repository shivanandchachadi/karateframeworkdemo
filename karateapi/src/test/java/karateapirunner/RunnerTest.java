package karateapirunner;

import org.junit.Test;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;



public class RunnerTest {
	
	@Test
    public void testParallel() {
		
		Results results = Runner.path("C:\\Users\\SONY\\git\\karatefw\\karateapi\\src\\test\\java\\resources\\samplefeature.feature").tags("~@ignore").outputCucumberJson(true).parallel(2);
       
        
    } 

}
