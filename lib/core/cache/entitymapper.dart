abstract class EntityMapper<T, D> {
  T cachedToMap(D param);
  D mapToCached(T param);
}
