Require Export sf1.

Theorem plus_n_0_firsttry : forall n : nat,
  n = n + 0.
Proof.
  intros n.
  simpl.
Abort.

Theorem plus_n_secondtry : forall n : nat,
  n = n + 0.

Proof.
  intros. destruct n as [| n'].
  - (* n = 0 *)
    reflexivity.
  - (* n = S n' *)
    simpl.
Abort.

Theorem plus_n_0 : forall n : nat, n = n + 0.
Proof.
  intros. induction n as [| n' IHn'].
  - (* n = 0 *) reflexivity.
  - (* n = S n' *) simpl.
    rewrite <- IHn'.
    reflexivity.
Qed.

Theorem minus_diag : forall n : nat, minus n n = 0.
Proof.
  intros n. induction n as [| n' IHn'].
  - (* n = 0 *) simpl. reflexivity.
  - (* n = S n' *) simpl.
    rewrite -> IHn'. reflexivity.
Qed.

Theorem mult_0_r: forall n : nat, n * 0 = 0.
Proof.
  induction n as [|n' IHn'].
  - reflexivity.
  - simpl. rewrite IHn'. reflexivity.
Qed.

Theorem plus_n_Sm : forall n m : nat,
  S(n + m) = n + (S m).
Proof.
  intros n m. induction n as [|n' IHn'].
  - reflexivity.
  - simpl. rewrite IHn'. reflexivity.
Qed.

Theorem plus_comm : forall n m : nat,
  n + m = m + n.
Proof.
  intros n m. induction n as [|n' IHn'].
  simpl. rewrite <- plus_n_0. reflexivity.
  simpl. rewrite <- plus_n_Sm. rewrite -> IHn'. reflexivity.
Qed.

Theorem plus_assoc : forall n m p : nat,
  n + (m + p) = (n + m) + p.
Proof.
  intros n m p.
  induction n as [|n' IHn'].
  simpl. reflexivity.
  simpl. rewrite <- IHn'. reflexivity.
Qed.

Fixpoint double (n : nat) : nat :=
  match n with
  | 0 => 0
  | S n' => S (S (double n'))
  end.

Lemma double_plus : forall n, double n = n + n.
Proof.
  intros n.
  induction n.
  - reflexivity.
  - simpl. rewrite -> IHn. rewrite -> plus_n_Sm. reflexivity.
Qed.

Theorem evenb_S : forall n : nat,
  evenb (S n) = negb (evenb n).
Proof.
  induction n as [|n' IHn'].
  - simpl. reflexivity.
  - rewrite -> IHn'. simpl.
    rewrite negb_applied_twice.
    reflexivity. reflexivity.
Qed.

Theorem mult_0_plus' : forall n m : nat,
  (0 + n) * m = n * m.
Proof.
  intros n m.
  assert (H: 0 + n = n). { reflexivity. }
  rewrite -> H.
  reflexivity.
Qed.

Theorem plus_rearrange_firsttry : forall n m p q : nat,
  (n + m) + (p + q) = (m + n) + (p + q).
Proof.
  intros n m p q.
  rewrite -> plus_comm.
Abort.

Theorem plus_rearrange : forall n m p q : nat,
  (n + m) + (p + q) = (m + n) + (p + q).
Proof.
  intros n m p q.
  assert (H: n + m = m + n).
  { rewrite -> plus_comm. reflexivity. }
  rewrite -> H. reflexivity.
Qed.

Theorem plus_swap : forall n m p : nat,
  n + (m + p) = m + (n + p).
Proof.
  intros n m p.
  rewrite -> plus_comm.
  rewrite <- plus_assoc.
  assert (H: p + n = n + p).
  { rewrite -> plus_comm. reflexivity. }
  rewrite -> H.
  reflexivity.
Qed.

Theorem mult_n_1 : forall n : nat, n = n * 1.
Proof.
  intros. induction n as [| n' IHn'].
  - (* n = 0 *) reflexivity.
  - (* n = S n' *) simpl.
    rewrite <- IHn'.
    reflexivity.
Qed.

Theorem mult_n_Sm : forall n m :nat,
  n * S m = n + (n * m).
Proof.
  intros n m.
  induction n as [|n' IHn'].
  reflexivity.
  simpl. rewrite IHn'. rewrite plus_swap. reflexivity.
Qed.

Theorem mult_comm : forall m n : nat,
  m * n = n * m.
Proof.
  intros n m.
  induction m as [|m' IHm'].
  - rewrite mult_0_r. reflexivity.
  - simpl.
    rewrite mult_n_Sm.
    rewrite IHm'.
    reflexivity.
Qed.

Theorem leb_refl : forall n : nat,
  true = leb n n.
Proof.
  intros n.
  induction n.
  - reflexivity.
  - simpl. rewrite IHn. reflexivity.
Qed.

Theorem zero_nbeq_S : forall n : nat,
  beq_nat 0 (S n) = false.
Proof.
  intros n. simpl. reflexivity.
Qed.

Theorem andb_false_r : forall b : bool,
  andb b false = false.
Proof.
  intros n.
  destruct n.
  - reflexivity.
  - reflexivity.
Qed.

Theorem plus_ble_compat_l : forall n m p : nat,
  leb n m = true ->
  leb (p + n) (p + m) = true.
Proof.
  intros n m p.
  intros H.
  induction p as [|p' IHp'].
  - simpl. rewrite H. reflexivity.
  - simpl. rewrite IHp'. reflexivity.
Qed.

Theorem S_nbeq_0 : forall n : nat,
  beq_nat (S n) 0 = false.
Proof.
  destruct n.
  - reflexivity.
  - simpl. reflexivity.
Qed.

Theorem mult_1_l : forall n : nat, 1 * n = n.
Proof.
  intros n.
  destruct n.
  - reflexivity.
  - simpl. rewrite plus_n_0. reflexivity.
Qed.

Theorem all3_spec : forall b c : bool,
  orb
    (andb b c)
    (orb (negb b) (negb c)) = true.
Proof.
  intros b c.
  destruct b.
  - simpl. destruct c.
    { reflexivity. }
    { reflexivity. }
  - simpl. reflexivity.
Qed.

Theorem mult_plus_distr_r : forall n m p : nat,
  (n + m) * p = (n * p) + (m * p).
Proof.
 intros n m p.
  induction p as [|p' IHp'].
  - rewrite mult_0_r.
    rewrite (mult_0_r n).
    rewrite (mult_0_r m).
    reflexivity.
  - rewrite mult_n_Sm.
    rewrite (mult_n_Sm n p').
    rewrite (mult_n_Sm m p').
    rewrite IHp'.
(* Try to shorten the proof. *)
    rewrite plus_assoc.
    rewrite plus_swap.
    rewrite plus_assoc.
    rewrite plus_swap.
    rewrite plus_assoc.
    reflexivity.
Qed.

Theorem mult_assoc : forall n m p : nat,
  n * (m * p) = (n * m) * p.
Proof.
  intros n m p.
  induction p as [|p' IHp'].
  - rewrite mult_0_r.
    rewrite mult_0_r.
    rewrite mult_comm.
    reflexivity.
  - rewrite mult_n_Sm.
    rewrite mult_comm.
    rewrite mult_plus_distr_r.
    rewrite (mult_comm (m*p') n).
    rewrite IHp'.
    rewrite mult_n_Sm.
    rewrite (mult_comm m n).
    reflexivity.
Qed.

Theorem beq_nat_refl : forall n : nat,
  true = beq_nat n n.
Proof.
  induction n as [|n' IHn'].
  - simpl. reflexivity.
  - simpl. rewrite <- IHn'. reflexivity.
Qed.

Theorem plus_swap' : forall n m p : nat,
  n + (m + p) = m + (n + p).
Proof.
  intros n m p.
  rewrite plus_assoc.
  rewrite (plus_assoc m n p) .
  replace (m + n) with (n + m).
  reflexivity.
  rewrite plus_comm.
  reflexivity.
Qed.

Theorem nat_succ : forall n : nat,
  n + 1 = S(n).
Proof.
  induction n as [|n' IHn'].
  - reflexivity.
  - simpl. rewrite IHn'. reflexivity.
Qed.

Theorem bin_to_nat_pres_incr : forall b : bin,
  bin_to_nat(incr b) = S (bin_to_nat(b)).
Proof.
  induction b as [|b' IHTb'|b' IHTPOb'].
  - simpl. reflexivity.
  - simpl.
    rewrite <- (plus_n_0 (bin_to_nat b')).
    rewrite (nat_succ (bin_to_nat b' + bin_to_nat b')).
    reflexivity.
  - simpl.
    rewrite IHTPOb'.
    simpl.
    rewrite <- (plus_n_0 (bin_to_nat b')).
    rewrite <- (nat_succ (bin_to_nat b')).
    rewrite plus_assoc.
    reflexivity.
Qed.

Fixpoint nat_to_bin (n: nat) : bin :=
  match n with
  |0 => O
  |S n => incr(nat_to_bin n)
  end.

Example nat_to_bin1 : nat_to_bin 5 = TPO (T (TPO O)).
Proof. simpl. reflexivity. Qed.

Theorem bin_to_nat_S: forall b : bin,
  bin_to_nat(incr b) = S(bin_to_nat b).
Proof.
  induction b.
  - simpl. reflexivity.
  - simpl. rewrite <- plus_n_0.
    rewrite <- (nat_succ(bin_to_nat b + bin_to_nat b)).
    reflexivity.
  - simpl. rewrite <- plus_n_0. rewrite <- plus_n_0.
    rewrite <- (nat_succ(bin_to_nat b + bin_to_nat b + 1)).
    rewrite IHb. rewrite <- nat_succ.
    rewrite plus_swap.
    rewrite plus_assoc.
    rewrite plus_assoc.
    reflexivity.
Qed.

Theorem bin_to_nat_reflexivity: forall n : nat,
  bin_to_nat(nat_to_bin n) = n.
Proof.
  induction n as [|n' IHn'].
  - simpl. reflexivity.
  - simpl.
    rewrite bin_to_nat_S.
    rewrite IHn'.
    reflexivity.
Qed.







