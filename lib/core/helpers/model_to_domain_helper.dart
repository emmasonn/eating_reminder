abstract class ModelConverter<M, D> {
  D modelToDomain(M param);
  M domainToModel(D param);
}
