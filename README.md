# ZuiTweak-magisk

## 개요
**ZuiTweak-magisk**은 Lenovo Zui 기반 롬에 여러 가지 트윅을 적용하는 Magisk/APatch 모듈입니다.

## 주요 기능
### Xiaoxin Pad Pro 12.7
1. **한국 Locale 적용:** 시스템 전체에 한국 로케일을 적용합니다.
   - `framework.jar`, `services.jar`의 `test_mode` 설정 값을 변경하고 변경된 값만 후킹하여 다국어 처리를 구현합니다.
2. **이전 버전 한글 번역 적용:** 이전 버전의 한글 번역을 적용합니다.
   - RRO(Resource Runtime Overlay)를 이용한 다국어 처리 방식으로 구현합니다.
3. **Play Store 활성화:** Google Play 스토어를 활성화합니다.
4. **불필요한 앱/중국 앱 삭제:** 기본적으로 설치된 불필요한 앱 및 중국 앱을 삭제합니다.

### Lenovo Y700 2023
1. **Multiple Space 활성화:** 복제 공간(분신 공간) 기능을 활성화 합니다.
   - [ZuiTweak](https://github.com/forumi0721/ZuiTweak) Xposed 모듈 설치 및 활성화 필요
2. **불필요한 앱:** 기본적으로 설치된 불필요한 앱을 삭제합니다.

### 공통
1. **Pen(Stylus) 서비스 활성화:** 펜 페어링 없이 펜 기능을 활성화합니다.
2. **DRM 컨텐츠 재생을 위한 Widevine L3 강제 적용:** Widevine L3를 강제 적용하여 DRM 콘텐츠를 재생할 수 있게 합니다.
3. **Bootanimation 교체:** 부팅 애니메이션을 교체합니다.

## 소스 코드
소스 코드는 GitHub에서 확인할 수 있습니다: [ZuiTweak-magisk 소스 코드](https://github.com/forumi0721/ZuiTweak-magisk)

## License
이 프로젝트는 GPLv2 라이선스를 따릅니다. 자세한 내용은 [LICENSE](https://github.com/forumi0721/ZuiTweak-magisk/blob/main/LICENSE)를 참고하세요.

## 설치 방법
1. **Magisk/APatch 설치**
   - ZuiTweak-magisk을 사용하려면 먼저 루팅 되어 있어야합니다. (APatch 추천)
2. **ZuiTweak-magisk 다운로드 및 설치**
   - [Release 페이지](https://github.com/forumi0721/ZuiTweak-magisk/releases)에서 최신 버전을 다운로드하여 설치합니다.
3. **ZuiTweak (Xposed 모듈) 설치 및 활성화**
   - Xposed 설치 후, ZuiTweak 모듈을 활성화합니다.

## 중요 사항
- 완전한 기능이 아니라 오류가 발생할 수 있습니다.

## 문의
앱 사용 중 문제가 발생하거나 문의사항이 있으면 [Issues 페이지](https://github.com/forumi0721/ZuiTweak-magisk/issues)를 통해 알려주세요.

