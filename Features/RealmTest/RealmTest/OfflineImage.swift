class OfflineImage: Object {
    @Persisted var id: String?
    @Persisted var uriStr: String?
    @Persisted var width: Float = 0.0
    @Persisted var height: Float = 0.0
    
    // Core Data에서는 관계의 inverse를 설정했지만, Realm에서는 직접 설정 X
    @Persisted(originProperty: "beforeImages") var defect: LinkingObjects<OfflineDefect>
}