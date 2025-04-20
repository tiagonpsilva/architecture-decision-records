# ADR-050: Testes de Interface com Selenium

## Status

Proposto

## Contexto

A necessidade de testes automatizados de interface que sejam:
- Compatíveis com múltiplos navegadores
- Integráveis com diferentes linguagens
- Suportados por ferramentas de CI/CD
- Capazes de testar aplicações complexas
- Maduros e bem estabelecidos no mercado

O Selenium WebDriver se apresenta como uma solução consolidada que atende a esses requisitos.

## Decisão

Implementaremos o Selenium WebDriver como ferramenta complementar de testes de interface:

### 1. Configuração Base
```java
// WebDriverConfig.java
public class WebDriverConfig {
    private static WebDriver driver;
    
    public static WebDriver getDriver() {
        if (driver == null) {
            ChromeOptions options = new ChromeOptions();
            options.addArguments("--headless");
            options.addArguments("--no-sandbox");
            options.addArguments("--disable-dev-shm-usage");
            
            driver = new ChromeDriver(options);
            driver.manage().timeouts().implicitlyWait(10, TimeUnit.SECONDS);
            driver.manage().window().setSize(new Dimension(1280, 720));
        }
        return driver;
    }
    
    public static void closeDriver() {
        if (driver != null) {
            driver.quit();
            driver = null;
        }
    }
}
```

### 2. Page Objects
```java
// LoginPage.java
public class LoginPage {
    private WebDriver driver;
    private By emailField = By.id("email");
    private By passwordField = By.id("password");
    private By loginButton = By.id("login-button");
    private By errorMessage = By.className("error-message");
    
    public LoginPage(WebDriver driver) {
        this.driver = driver;
        PageFactory.initElements(driver, this);
    }
    
    public void login(String email, String password) {
        driver.findElement(emailField).sendKeys(email);
        driver.findElement(passwordField).sendKeys(password);
        driver.findElement(loginButton).click();
    }
    
    public boolean isErrorDisplayed() {
        return driver.findElement(errorMessage).isDisplayed();
    }
}

// DashboardPage.java
public class DashboardPage {
    private WebDriver driver;
    private By welcomeMessage = By.id("welcome");
    private By userMenu = By.id("user-menu");
    
    public DashboardPage(WebDriver driver) {
        this.driver = driver;
        PageFactory.initElements(driver, this);
    }
    
    public boolean isLoaded() {
        return driver.getCurrentUrl().contains("/dashboard") &&
               driver.findElement(welcomeMessage).isDisplayed();
    }
}
```

### 3. Testes
```java
// LoginTest.java
@Test
public class LoginTest {
    private WebDriver driver;
    private LoginPage loginPage;
    private DashboardPage dashboardPage;
    
    @BeforeClass
    public void setUp() {
        driver = WebDriverConfig.getDriver();
        loginPage = new LoginPage(driver);
        dashboardPage = new DashboardPage(driver);
    }
    
    @Test
    public void testSuccessfulLogin() {
        driver.get("http://localhost:3000/login");
        loginPage.login("user@example.com", "password123");
        Assert.assertTrue(dashboardPage.isLoaded());
    }
    
    @Test
    public void testFailedLogin() {
        driver.get("http://localhost:3000/login");
        loginPage.login("invalid@example.com", "wrongpass");
        Assert.assertTrue(loginPage.isErrorDisplayed());
    }
    
    @AfterClass
    public void tearDown() {
        WebDriverConfig.closeDriver();
    }
}
```

### 4. Integração CI/CD
```yaml
# .github/workflows/selenium.yml
name: Selenium Tests
on: [push]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: actions/setup-java@v2
        with:
          java-version: '11'
      - name: Install Chrome
        run: |
          wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
          sudo apt install ./google-chrome-stable_current_amd64.deb
      - name: Run Tests
        run: mvn test
```

## Consequências

### Positivas
- Suporte a múltiplos navegadores
- Integração com várias linguagens
- Comunidade grande e ativa
- Ferramentas de suporte maduras
- Boa documentação

### Negativas
- Configuração inicial complexa
- Testes podem ser instáveis
- Execução mais lenta que alternativas modernas
- Necessidade de drivers específicos
- Manutenção mais trabalhosa

## Riscos
- Testes frágeis e instáveis
- Problemas de compatibilidade
- Tempo de execução longo
- Custo de manutenção alto

## Alternativas Consideradas
1. Cypress
2. Playwright
3. TestCafe
4. Puppeteer
5. WebdriverIO

## Referências
- Selenium Documentation
- Selenium WebDriver Documentation
- Page Object Pattern
- Testing Best Practices
- Selenium Design Patterns

## Notas
- Manter drivers atualizados
- Implementar esperas explícitas
- Usar Page Objects consistentemente
- Documentar padrões de teste

## Exemplo de Configuração
```xml
<!-- pom.xml -->
<dependencies>
    <dependency>
        <groupId>org.seleniumhq.selenium</groupId>
        <artifactId>selenium-java</artifactId>
        <version>4.8.0</version>
    </dependency>
    <dependency>
        <groupId>org.testng</groupId>
        <artifactId>testng</artifactId>
        <version>7.7.0</version>
    </dependency>
    <dependency>
        <groupId>io.github.bonigarcia</groupId>
        <artifactId>webdrivermanager</artifactId>
        <version>5.3.2</version>
    </dependency>
</dependencies>
```

## Métricas de Avaliação
- Taxa de sucesso dos testes
- Tempo médio de execução
- Número de falsos positivos
- Cobertura de browsers
- Tempo de manutenção 